module 0x141240ba88be580fc65b7038aaffbb6ed955e770997269ebc3954796be8f0c6d::suipaynft {
    struct CreatorCap has key {
        id: 0x2::object::UID,
    }

    struct ContractInfo has key {
        id: 0x2::object::UID,
        owner_address: address,
        required_payment: u64,
        count: u16,
        nfts: vector<Traits>,
    }

    struct NFT has store, key {
        id: 0x2::object::UID,
        traits: vector<0x1::string::String>,
        name: 0x1::string::String,
        nr: 0x1::string::String,
    }

    struct Whitelist has store, key {
        id: 0x2::object::UID,
        discountPct: u8,
        trait: 0x1::string::String,
    }

    struct Traits has store {
        background: 0x1::string::String,
        body: 0x1::string::String,
        decoration: 0x1::string::String,
        face: 0x1::string::String,
        isUsed: bool,
    }

    struct NFTMinted has copy, drop {
        id: 0x2::object::ID,
        minted_by: address,
    }

    struct SUIPAYNFT has drop {
        dummy_field: bool,
    }

    public entry fun add_discount(arg0: &CreatorCap, arg1: address, arg2: 0x1::string::String, arg3: u8, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = Whitelist{
            id          : 0x2::object::new(arg4),
            discountPct : arg3,
            trait       : arg2,
        };
        0x2::transfer::public_transfer<Whitelist>(v0, arg1);
    }

    public entry fun add_field(arg0: &CreatorCap, arg1: &mut 0x2::display::Display<NFT>, arg2: 0x1::string::String, arg3: 0x1::string::String) {
        0x2::display::add<NFT>(arg1, arg2, arg3);
    }

    public entry fun add_trait(arg0: &CreatorCap, arg1: &mut NFT, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) {
        0x1::vector::push_back<0x1::string::String>(&mut arg1.traits, arg2);
    }

    public fun contract_info(arg0: &ContractInfo) : &ContractInfo {
        arg0
    }

    fun convert(arg0: u16) : 0x1::string::String {
        let v0 = 0x1::string::utf8(b"");
        let v1 = b"";
        0x1::vector::push_back<u8>(&mut v1, ((arg0 >> 8 & 255) as u8));
        0x1::vector::push_back<u8>(&mut v1, ((arg0 & 255) as u8));
        0x1::string::append_utf8(&mut v0, 0x2::hex::encode(v1));
        v0
    }

    public entry fun destroy(arg0: NFT) {
        let NFT {
            id     : v0,
            traits : _,
            name   : _,
            nr     : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public entry fun edit_field(arg0: &CreatorCap, arg1: &mut 0x2::display::Display<NFT>, arg2: 0x1::string::String, arg3: 0x1::string::String) {
        0x2::display::edit<NFT>(arg1, arg2, arg3);
    }

    fun genNextFree(arg0: u64, arg1: &mut ContractInfo) : u64 {
        let v0;
        loop {
            v0 = 0x1::vector::borrow_mut<Traits>(&mut arg1.nfts, arg0);
            if (v0.isUsed == false) {
                break
            };
            let v1 = arg0 + 1;
            arg0 = v1 % (50 as u64);
        };
        v0.isUsed = true;
        arg0
    }

    fun init(arg0: SUIPAYNFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = CreatorCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<CreatorCap>(v0, 0x2::tx_context::sender(arg1));
        let v1 = 0x1::vector::empty<0x1::string::String>();
        let v2 = &mut v1;
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"link"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"creator"));
        let v3 = 0x1::vector::empty<0x1::string::String>();
        let v4 = &mut v3;
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"https://axelra.net/nft/{nr}.html"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"https://axelra.net/nft/{nr}.png"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"Test Sui Pay NFT5"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"https://axelra.net/nft"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"Sui Pay Test Team"));
        let v5 = 0x2::package::claim<SUIPAYNFT>(arg0, arg1);
        let v6 = 0x2::display::new_with_fields<NFT>(&v5, v1, v3, arg1);
        0x2::display::update_version<NFT>(&mut v6);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v5, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<NFT>>(v6, 0x2::tx_context::sender(arg1));
        let v7 = 0x1::vector::empty<Traits>();
        let v8 = Traits{
            background : 0x1::string::utf8(b"Plain"),
            body       : 0x1::string::utf8(b"Pink"),
            decoration : 0x1::string::utf8(b"Bubbles"),
            face       : 0x1::string::utf8(b"Frown"),
            isUsed     : false,
        };
        0x1::vector::push_back<Traits>(&mut v7, v8);
        let v9 = Traits{
            background : 0x1::string::utf8(b"Plain"),
            body       : 0x1::string::utf8(b"Red"),
            decoration : 0x1::string::utf8(b"Bubbles"),
            face       : 0x1::string::utf8(b"Frown"),
            isUsed     : false,
        };
        0x1::vector::push_back<Traits>(&mut v7, v9);
        let v10 = Traits{
            background : 0x1::string::utf8(b"Plain"),
            body       : 0x1::string::utf8(b"Green"),
            decoration : 0x1::string::utf8(b"Coral"),
            face       : 0x1::string::utf8(b"Frown"),
            isUsed     : false,
        };
        0x1::vector::push_back<Traits>(&mut v7, v10);
        let v11 = Traits{
            background : 0x1::string::utf8(b"Plain"),
            body       : 0x1::string::utf8(b"Pink"),
            decoration : 0x1::string::utf8(b"Coral"),
            face       : 0x1::string::utf8(b"Frown"),
            isUsed     : false,
        };
        0x1::vector::push_back<Traits>(&mut v7, v11);
        let v12 = Traits{
            background : 0x1::string::utf8(b"Plain"),
            body       : 0x1::string::utf8(b"Red"),
            decoration : 0x1::string::utf8(b"Coral"),
            face       : 0x1::string::utf8(b"Frown"),
            isUsed     : false,
        };
        0x1::vector::push_back<Traits>(&mut v7, v12);
        let v13 = Traits{
            background : 0x1::string::utf8(b"Plain"),
            body       : 0x1::string::utf8(b"Green"),
            decoration : 0x1::string::utf8(b"Fishes"),
            face       : 0x1::string::utf8(b"Frown"),
            isUsed     : false,
        };
        0x1::vector::push_back<Traits>(&mut v7, v13);
        let v14 = Traits{
            background : 0x1::string::utf8(b"Plain"),
            body       : 0x1::string::utf8(b"Orange"),
            decoration : 0x1::string::utf8(b"Fishes"),
            face       : 0x1::string::utf8(b"Frown"),
            isUsed     : false,
        };
        0x1::vector::push_back<Traits>(&mut v7, v14);
        let v15 = Traits{
            background : 0x1::string::utf8(b"Plain"),
            body       : 0x1::string::utf8(b"Pink"),
            decoration : 0x1::string::utf8(b"Fishes"),
            face       : 0x1::string::utf8(b"Frown"),
            isUsed     : false,
        };
        0x1::vector::push_back<Traits>(&mut v7, v15);
        let v16 = Traits{
            background : 0x1::string::utf8(b"Plain"),
            body       : 0x1::string::utf8(b"Pink"),
            decoration : 0x1::string::utf8(b"Submarine"),
            face       : 0x1::string::utf8(b"Frown"),
            isUsed     : false,
        };
        0x1::vector::push_back<Traits>(&mut v7, v16);
        let v17 = Traits{
            background : 0x1::string::utf8(b"Plain"),
            body       : 0x1::string::utf8(b"Green"),
            decoration : 0x1::string::utf8(b"Bubbles"),
            face       : 0x1::string::utf8(b"Happy"),
            isUsed     : false,
        };
        0x1::vector::push_back<Traits>(&mut v7, v17);
        let v18 = Traits{
            background : 0x1::string::utf8(b"Plain"),
            body       : 0x1::string::utf8(b"Orange"),
            decoration : 0x1::string::utf8(b"Bubbles"),
            face       : 0x1::string::utf8(b"Happy"),
            isUsed     : false,
        };
        0x1::vector::push_back<Traits>(&mut v7, v18);
        let v19 = Traits{
            background : 0x1::string::utf8(b"Plain"),
            body       : 0x1::string::utf8(b"Pink"),
            decoration : 0x1::string::utf8(b"Bubbles"),
            face       : 0x1::string::utf8(b"Happy"),
            isUsed     : false,
        };
        0x1::vector::push_back<Traits>(&mut v7, v19);
        let v20 = Traits{
            background : 0x1::string::utf8(b"Plain"),
            body       : 0x1::string::utf8(b"Green"),
            decoration : 0x1::string::utf8(b"Coral"),
            face       : 0x1::string::utf8(b"Happy"),
            isUsed     : false,
        };
        0x1::vector::push_back<Traits>(&mut v7, v20);
        let v21 = Traits{
            background : 0x1::string::utf8(b"Plain"),
            body       : 0x1::string::utf8(b"Orange"),
            decoration : 0x1::string::utf8(b"Coral"),
            face       : 0x1::string::utf8(b"Happy"),
            isUsed     : false,
        };
        0x1::vector::push_back<Traits>(&mut v7, v21);
        let v22 = Traits{
            background : 0x1::string::utf8(b"Plain"),
            body       : 0x1::string::utf8(b"Pink"),
            decoration : 0x1::string::utf8(b"Coral"),
            face       : 0x1::string::utf8(b"Happy"),
            isUsed     : false,
        };
        0x1::vector::push_back<Traits>(&mut v7, v22);
        let v23 = Traits{
            background : 0x1::string::utf8(b"Plain"),
            body       : 0x1::string::utf8(b"Purple"),
            decoration : 0x1::string::utf8(b"Coral"),
            face       : 0x1::string::utf8(b"Happy"),
            isUsed     : false,
        };
        0x1::vector::push_back<Traits>(&mut v7, v23);
        let v24 = Traits{
            background : 0x1::string::utf8(b"Plain"),
            body       : 0x1::string::utf8(b"Red"),
            decoration : 0x1::string::utf8(b"Coral"),
            face       : 0x1::string::utf8(b"Happy"),
            isUsed     : false,
        };
        0x1::vector::push_back<Traits>(&mut v7, v24);
        let v25 = Traits{
            background : 0x1::string::utf8(b"Plain"),
            body       : 0x1::string::utf8(b"Green"),
            decoration : 0x1::string::utf8(b"Fishes"),
            face       : 0x1::string::utf8(b"Happy"),
            isUsed     : false,
        };
        0x1::vector::push_back<Traits>(&mut v7, v25);
        let v26 = Traits{
            background : 0x1::string::utf8(b"Plain"),
            body       : 0x1::string::utf8(b"Pink"),
            decoration : 0x1::string::utf8(b"Fishes"),
            face       : 0x1::string::utf8(b"Happy"),
            isUsed     : false,
        };
        0x1::vector::push_back<Traits>(&mut v7, v26);
        let v27 = Traits{
            background : 0x1::string::utf8(b"Plain"),
            body       : 0x1::string::utf8(b"Green"),
            decoration : 0x1::string::utf8(b"Submarine"),
            face       : 0x1::string::utf8(b"Happy"),
            isUsed     : false,
        };
        0x1::vector::push_back<Traits>(&mut v7, v27);
        let v28 = Traits{
            background : 0x1::string::utf8(b"Plain"),
            body       : 0x1::string::utf8(b"Purple"),
            decoration : 0x1::string::utf8(b"Submarine"),
            face       : 0x1::string::utf8(b"Mask"),
            isUsed     : false,
        };
        0x1::vector::push_back<Traits>(&mut v7, v28);
        let v29 = Traits{
            background : 0x1::string::utf8(b"Plain"),
            body       : 0x1::string::utf8(b"Orange"),
            decoration : 0x1::string::utf8(b"Bubbles"),
            face       : 0x1::string::utf8(b"Pirate"),
            isUsed     : false,
        };
        0x1::vector::push_back<Traits>(&mut v7, v29);
        let v30 = Traits{
            background : 0x1::string::utf8(b"Plain"),
            body       : 0x1::string::utf8(b"Pink"),
            decoration : 0x1::string::utf8(b"Bubbles"),
            face       : 0x1::string::utf8(b"Pirate"),
            isUsed     : false,
        };
        0x1::vector::push_back<Traits>(&mut v7, v30);
        let v31 = Traits{
            background : 0x1::string::utf8(b"Plain"),
            body       : 0x1::string::utf8(b"Red"),
            decoration : 0x1::string::utf8(b"Bubbles"),
            face       : 0x1::string::utf8(b"Pirate"),
            isUsed     : false,
        };
        0x1::vector::push_back<Traits>(&mut v7, v31);
        let v32 = Traits{
            background : 0x1::string::utf8(b"Plain"),
            body       : 0x1::string::utf8(b"Green"),
            decoration : 0x1::string::utf8(b"Coral"),
            face       : 0x1::string::utf8(b"Pirate"),
            isUsed     : false,
        };
        0x1::vector::push_back<Traits>(&mut v7, v32);
        let v33 = Traits{
            background : 0x1::string::utf8(b"Plain"),
            body       : 0x1::string::utf8(b"Orange"),
            decoration : 0x1::string::utf8(b"Fishes"),
            face       : 0x1::string::utf8(b"Pirate"),
            isUsed     : false,
        };
        0x1::vector::push_back<Traits>(&mut v7, v33);
        let v34 = Traits{
            background : 0x1::string::utf8(b"Plain"),
            body       : 0x1::string::utf8(b"Purple"),
            decoration : 0x1::string::utf8(b"Submarine"),
            face       : 0x1::string::utf8(b"Sunglasses"),
            isUsed     : false,
        };
        0x1::vector::push_back<Traits>(&mut v7, v34);
        let v35 = Traits{
            background : 0x1::string::utf8(b"Plain"),
            body       : 0x1::string::utf8(b"Orange"),
            decoration : 0x1::string::utf8(b"Bubbles"),
            face       : 0x1::string::utf8(b"Wink"),
            isUsed     : false,
        };
        0x1::vector::push_back<Traits>(&mut v7, v35);
        let v36 = Traits{
            background : 0x1::string::utf8(b"Plain"),
            body       : 0x1::string::utf8(b"Red"),
            decoration : 0x1::string::utf8(b"Bubbles"),
            face       : 0x1::string::utf8(b"Wink"),
            isUsed     : false,
        };
        0x1::vector::push_back<Traits>(&mut v7, v36);
        let v37 = Traits{
            background : 0x1::string::utf8(b"Plain"),
            body       : 0x1::string::utf8(b"Green"),
            decoration : 0x1::string::utf8(b"Coral"),
            face       : 0x1::string::utf8(b"Wink"),
            isUsed     : false,
        };
        0x1::vector::push_back<Traits>(&mut v7, v37);
        let v38 = Traits{
            background : 0x1::string::utf8(b"Plain"),
            body       : 0x1::string::utf8(b"Purple"),
            decoration : 0x1::string::utf8(b"Coral"),
            face       : 0x1::string::utf8(b"Wink"),
            isUsed     : false,
        };
        0x1::vector::push_back<Traits>(&mut v7, v38);
        let v39 = Traits{
            background : 0x1::string::utf8(b"Plain"),
            body       : 0x1::string::utf8(b"Green"),
            decoration : 0x1::string::utf8(b"Fishes"),
            face       : 0x1::string::utf8(b"Wink"),
            isUsed     : false,
        };
        0x1::vector::push_back<Traits>(&mut v7, v39);
        let v40 = Traits{
            background : 0x1::string::utf8(b"Plain"),
            body       : 0x1::string::utf8(b"Orange"),
            decoration : 0x1::string::utf8(b"Fishes"),
            face       : 0x1::string::utf8(b"Wink"),
            isUsed     : false,
        };
        0x1::vector::push_back<Traits>(&mut v7, v40);
        let v41 = Traits{
            background : 0x1::string::utf8(b"Plain"),
            body       : 0x1::string::utf8(b"Purple"),
            decoration : 0x1::string::utf8(b"Fishes"),
            face       : 0x1::string::utf8(b"Wink"),
            isUsed     : false,
        };
        0x1::vector::push_back<Traits>(&mut v7, v41);
        let v42 = Traits{
            background : 0x1::string::utf8(b"Plain"),
            body       : 0x1::string::utf8(b"Red"),
            decoration : 0x1::string::utf8(b"Fishes"),
            face       : 0x1::string::utf8(b"Wink"),
            isUsed     : false,
        };
        0x1::vector::push_back<Traits>(&mut v7, v42);
        let v43 = Traits{
            background : 0x1::string::utf8(b"Plain"),
            body       : 0x1::string::utf8(b"Red"),
            decoration : 0x1::string::utf8(b"Submarine"),
            face       : 0x1::string::utf8(b"Wink"),
            isUsed     : false,
        };
        0x1::vector::push_back<Traits>(&mut v7, v43);
        let v44 = Traits{
            background : 0x1::string::utf8(b"Plain"),
            body       : 0x1::string::utf8(b"Orange"),
            decoration : 0x1::string::utf8(b"Treasure"),
            face       : 0x1::string::utf8(b"Wink"),
            isUsed     : false,
        };
        0x1::vector::push_back<Traits>(&mut v7, v44);
        let v45 = Traits{
            background : 0x1::string::utf8(b"Plain"),
            body       : 0x1::string::utf8(b"Green"),
            decoration : 0x1::string::utf8(b"Bubbles"),
            face       : 0x1::string::utf8(b"Worried"),
            isUsed     : false,
        };
        0x1::vector::push_back<Traits>(&mut v7, v45);
        let v46 = Traits{
            background : 0x1::string::utf8(b"Plain"),
            body       : 0x1::string::utf8(b"Orange"),
            decoration : 0x1::string::utf8(b"Bubbles"),
            face       : 0x1::string::utf8(b"Worried"),
            isUsed     : false,
        };
        0x1::vector::push_back<Traits>(&mut v7, v46);
        let v47 = Traits{
            background : 0x1::string::utf8(b"Plain"),
            body       : 0x1::string::utf8(b"Pink"),
            decoration : 0x1::string::utf8(b"Bubbles"),
            face       : 0x1::string::utf8(b"Worried"),
            isUsed     : false,
        };
        0x1::vector::push_back<Traits>(&mut v7, v47);
        let v48 = Traits{
            background : 0x1::string::utf8(b"Plain"),
            body       : 0x1::string::utf8(b"Red"),
            decoration : 0x1::string::utf8(b"Bubbles"),
            face       : 0x1::string::utf8(b"Worried"),
            isUsed     : false,
        };
        0x1::vector::push_back<Traits>(&mut v7, v48);
        let v49 = Traits{
            background : 0x1::string::utf8(b"Plain"),
            body       : 0x1::string::utf8(b"Green"),
            decoration : 0x1::string::utf8(b"Coral"),
            face       : 0x1::string::utf8(b"Worried"),
            isUsed     : false,
        };
        0x1::vector::push_back<Traits>(&mut v7, v49);
        let v50 = Traits{
            background : 0x1::string::utf8(b"Plain"),
            body       : 0x1::string::utf8(b"Orange"),
            decoration : 0x1::string::utf8(b"Coral"),
            face       : 0x1::string::utf8(b"Worried"),
            isUsed     : false,
        };
        0x1::vector::push_back<Traits>(&mut v7, v50);
        let v51 = Traits{
            background : 0x1::string::utf8(b"Plain"),
            body       : 0x1::string::utf8(b"Pink"),
            decoration : 0x1::string::utf8(b"Coral"),
            face       : 0x1::string::utf8(b"Worried"),
            isUsed     : false,
        };
        0x1::vector::push_back<Traits>(&mut v7, v51);
        let v52 = Traits{
            background : 0x1::string::utf8(b"Plain"),
            body       : 0x1::string::utf8(b"Red"),
            decoration : 0x1::string::utf8(b"Coral"),
            face       : 0x1::string::utf8(b"Worried"),
            isUsed     : false,
        };
        0x1::vector::push_back<Traits>(&mut v7, v52);
        let v53 = Traits{
            background : 0x1::string::utf8(b"Plain"),
            body       : 0x1::string::utf8(b"Green"),
            decoration : 0x1::string::utf8(b"Fishes"),
            face       : 0x1::string::utf8(b"Worried"),
            isUsed     : false,
        };
        0x1::vector::push_back<Traits>(&mut v7, v53);
        let v54 = Traits{
            background : 0x1::string::utf8(b"Plain"),
            body       : 0x1::string::utf8(b"Orange"),
            decoration : 0x1::string::utf8(b"Fishes"),
            face       : 0x1::string::utf8(b"Worried"),
            isUsed     : false,
        };
        0x1::vector::push_back<Traits>(&mut v7, v54);
        let v55 = Traits{
            background : 0x1::string::utf8(b"Plain"),
            body       : 0x1::string::utf8(b"Pink"),
            decoration : 0x1::string::utf8(b"Fishes"),
            face       : 0x1::string::utf8(b"Worried"),
            isUsed     : false,
        };
        0x1::vector::push_back<Traits>(&mut v7, v55);
        let v56 = Traits{
            background : 0x1::string::utf8(b"Plain"),
            body       : 0x1::string::utf8(b"Pride"),
            decoration : 0x1::string::utf8(b"Fishes"),
            face       : 0x1::string::utf8(b"Worried"),
            isUsed     : false,
        };
        0x1::vector::push_back<Traits>(&mut v7, v56);
        let v57 = Traits{
            background : 0x1::string::utf8(b"Plain"),
            body       : 0x1::string::utf8(b"Red"),
            decoration : 0x1::string::utf8(b"Fishes"),
            face       : 0x1::string::utf8(b"Worried"),
            isUsed     : false,
        };
        0x1::vector::push_back<Traits>(&mut v7, v57);
        let v58 = ContractInfo{
            id               : 0x2::object::new(arg1),
            owner_address    : 0x2::tx_context::sender(arg1),
            required_payment : 100000000000,
            count            : 0,
            nfts             : v7,
        };
        0x2::transfer::share_object<ContractInfo>(v58);
    }

    public entry fun mint(arg0: &mut ContractInfo, arg1: 0x1::string::String, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = arg0.required_payment;
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg2) >= v0, 0);
        let v1 = 0x2::tx_context::sender(arg3);
        mintInternal(0x1::vector::empty<0x1::string::String>(), arg0, v0, arg1, arg2, v1, arg3);
    }

    public entry fun mintDiscount(arg0: &mut ContractInfo, arg1: &Whitelist, arg2: 0x1::string::String, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = arg0.required_payment * (arg1.discountPct as u64) / 100;
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg3) >= v0, 0);
        let v1 = 0x1::vector::empty<0x1::string::String>();
        0x1::vector::push_back<0x1::string::String>(&mut v1, arg1.trait);
        let v2 = 0x2::tx_context::sender(arg4);
        mintInternal(v1, arg0, v0, arg2, arg3, v2, arg4);
    }

    fun mintInternal(arg0: vector<0x1::string::String>, arg1: &mut ContractInfo, arg2: u64, arg3: 0x1::string::String, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: address, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.count < 50, 1);
        arg1.count = arg1.count + 1;
        0x2::pay::split_and_transfer<0x2::sui::SUI>(&mut arg4, arg2, arg1.owner_address, arg6);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg4, arg5);
        let v0 = genNextFree(0x141240ba88be580fc65b7038aaffbb6ed955e770997269ebc3954796be8f0c6d::random::rand_u64(arg6) % (50 as u64), arg1);
        let v1 = NFT{
            id     : 0x2::object::new(arg6),
            traits : arg0,
            name   : arg3,
            nr     : convert((v0 as u16)),
        };
        let v2 = 0x1::vector::borrow<Traits>(&arg1.nfts, v0);
        let v3 = 0x1::string::utf8(b"background: ");
        let v4 = &mut v3;
        0x1::string::append(v4, v2.background);
        0x1::vector::push_back<0x1::string::String>(&mut arg0, *v4);
        let v5 = 0x1::string::utf8(b"body: ");
        let v6 = &mut v5;
        0x1::string::append(v6, v2.background);
        0x1::vector::push_back<0x1::string::String>(&mut arg0, *v6);
        let v7 = 0x1::string::utf8(b"decoration: ");
        let v8 = &mut v7;
        0x1::string::append(v8, v2.decoration);
        0x1::vector::push_back<0x1::string::String>(&mut arg0, *v8);
        let v9 = 0x1::string::utf8(b"face: ");
        let v10 = &mut v9;
        0x1::string::append(v10, v2.decoration);
        0x1::vector::push_back<0x1::string::String>(&mut arg0, *v10);
        let v11 = NFTMinted{
            id        : 0x2::object::id<NFT>(&v1),
            minted_by : arg5,
        };
        0x2::event::emit<NFTMinted>(v11);
        0x2::transfer::public_transfer<NFT>(v1, arg5);
    }

    public fun pay_nft(arg0: &NFT) : &NFT {
        arg0
    }

    public entry fun remove_field(arg0: &CreatorCap, arg1: &mut 0x2::display::Display<NFT>, arg2: 0x1::string::String) {
        0x2::display::remove<NFT>(arg1, arg2);
    }

    public entry fun set_owner_address(arg0: &CreatorCap, arg1: &mut ContractInfo, arg2: address) {
        arg1.owner_address = arg2;
    }

    public entry fun set_required_payment(arg0: &CreatorCap, arg1: &mut ContractInfo, arg2: u64) {
        arg1.required_payment = arg2;
    }

    public fun whitelist(arg0: &Whitelist) : &Whitelist {
        arg0
    }

    // decompiled from Move bytecode v6
}

