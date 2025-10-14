module 0x63c447201961584eb8da40da3a1347cb7169132b0fb6f244e525455f83a6162e::alkimi_legacy_nft {
    struct AlkimiLegacyNFT has key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        swapped_token: 0x1::string::String,
        user_address: address,
        background: 0x1::string::String,
        scales: 0x1::string::String,
        clothes: 0x1::string::String,
        head: 0x1::string::String,
        mouth: 0x1::string::String,
        eyes: 0x1::string::String,
        hands: 0x1::string::String,
        blob_id: 0x1::string::String,
    }

    struct SwapMintCap has store, key {
        id: 0x2::object::UID,
    }

    struct GlobalConfig has key {
        id: 0x2::object::UID,
        base_uri: 0x1::string::String,
    }

    struct MetadataRegistry has key {
        id: 0x2::object::UID,
        current_amounts: 0x2::table::Table<0x2::object::ID, 0x1::string::String>,
        additional_metadata: 0x2::table::Table<0x2::object::ID, 0x2::table::Table<0x1::string::String, 0x1::string::String>>,
    }

    struct AmountUpdated has copy, drop {
        nft_id: 0x2::object::ID,
        old_amount: 0x1::string::String,
        new_amount: 0x1::string::String,
        updated_by: address,
    }

    struct ALKIMI_LEGACY_NFT has drop {
        dummy_field: bool,
    }

    struct AlkimiLegacyNFTMinted has copy, drop {
        nft_id: 0x2::object::ID,
        recipient: address,
        swapped_amount: 0x1::string::String,
    }

    public fun add_custom_metadata(arg0: &SwapMintCap, arg1: &mut MetadataRegistry, arg2: 0x2::object::ID, arg3: vector<u8>, arg4: vector<u8>, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::string::utf8(arg3);
        if (!0x2::table::contains<0x2::object::ID, 0x2::table::Table<0x1::string::String, 0x1::string::String>>(&arg1.additional_metadata, arg2)) {
            0x2::table::add<0x2::object::ID, 0x2::table::Table<0x1::string::String, 0x1::string::String>>(&mut arg1.additional_metadata, arg2, 0x2::table::new<0x1::string::String, 0x1::string::String>(arg5));
        };
        let v1 = 0x2::table::borrow_mut<0x2::object::ID, 0x2::table::Table<0x1::string::String, 0x1::string::String>>(&mut arg1.additional_metadata, arg2);
        if (0x2::table::contains<0x1::string::String, 0x1::string::String>(v1, v0)) {
            0x2::table::remove<0x1::string::String, 0x1::string::String>(v1, v0);
        };
        0x2::table::add<0x1::string::String, 0x1::string::String>(v1, v0, 0x1::string::utf8(arg4));
    }

    public fun add_metadata(arg0: &mut 0x2::display::Display<AlkimiLegacyNFT>, arg1: vector<u8>, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::display::add<AlkimiLegacyNFT>(arg0, 0x1::string::utf8(arg1), 0x1::string::utf8(arg2));
        0x2::display::update_version<AlkimiLegacyNFT>(arg0);
    }

    public fun background(arg0: &AlkimiLegacyNFT) : 0x1::string::String {
        arg0.background
    }

    public fun blob_id(arg0: &AlkimiLegacyNFT) : 0x1::string::String {
        arg0.blob_id
    }

    public fun clothes(arg0: &AlkimiLegacyNFT) : 0x1::string::String {
        arg0.clothes
    }

    public fun eyes(arg0: &AlkimiLegacyNFT) : 0x1::string::String {
        arg0.eyes
    }

    public fun get_base_uri(arg0: &GlobalConfig) : 0x1::string::String {
        arg0.base_uri
    }

    public fun get_collection_name(arg0: &AlkimiLegacyNFT) : 0x1::string::String {
        0x1::string::utf8(b"AlEx: Legends Of The Deep")
    }

    public fun get_creator(arg0: &AlkimiLegacyNFT) : 0x1::string::String {
        0x1::string::utf8(b"Alkimi")
    }

    public fun get_custom_metadata(arg0: &MetadataRegistry, arg1: 0x2::object::ID, arg2: vector<u8>) : 0x1::option::Option<0x1::string::String> {
        let v0 = 0x1::string::utf8(arg2);
        if (!0x2::table::contains<0x2::object::ID, 0x2::table::Table<0x1::string::String, 0x1::string::String>>(&arg0.additional_metadata, arg1)) {
            0x1::option::none<0x1::string::String>()
        } else {
            let v2 = 0x2::table::borrow<0x2::object::ID, 0x2::table::Table<0x1::string::String, 0x1::string::String>>(&arg0.additional_metadata, arg1);
            if (0x2::table::contains<0x1::string::String, 0x1::string::String>(v2, v0)) {
                0x1::option::some<0x1::string::String>(*0x2::table::borrow<0x1::string::String, 0x1::string::String>(v2, v0))
            } else {
                0x1::option::none<0x1::string::String>()
            }
        }
    }

    public fun get_image_url(arg0: &AlkimiLegacyNFT, arg1: &GlobalConfig) : 0x1::string::String {
        let v0 = arg1.base_uri;
        0x1::string::append(&mut v0, arg0.blob_id);
        v0
    }

    public fun hands(arg0: &AlkimiLegacyNFT) : 0x1::string::String {
        arg0.hands
    }

    public fun head(arg0: &AlkimiLegacyNFT) : 0x1::string::String {
        arg0.head
    }

    fun init(arg0: ALKIMI_LEGACY_NFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = 0x2::package::claim<ALKIMI_LEGACY_NFT>(arg0, arg1);
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"swapped_amount"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"collection_name"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"creator"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"attributes"));
        let v4 = 0x1::vector::empty<0x1::string::String>();
        let v5 = &mut v4;
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(x"42656e65617468207468652073757266616365206c696573206120776f726c6420666577206461726520746f206578706c6f72652e20416c45782076656e747572657320696e746f20746865206f6365616e2773206465707468732c20756e636f766572696e672068696464656e2074726561737572657320616e64206d79737465726965732074686174206d6972726f722074686520756e74617070656420706f74656e7469616c206f6620746865206f70656e207765622e0a536f756c626f756e642070726f6f66206f66207b737761707065645f746f6b656e7d202441445320746f6b656e73207377617070656420746f20414c4b494d49"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"https://aggregator.walrus-mainnet.walrus.space/v1/blobs/{blob_id}"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"{swapped_token}"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"AlEx: Legends Of The Deep"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"Alkimi"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"Background: {background}, Clothes: {clothes}, Scales: {scales}, Head: {head}, Mouth: {mouth}, Eyes: {eyes}, Hands: {hands}"));
        let v6 = 0x2::display::new_with_fields<AlkimiLegacyNFT>(&v1, v2, v4, arg1);
        0x2::display::update_version<AlkimiLegacyNFT>(&mut v6);
        let v7 = SwapMintCap{id: 0x2::object::new(arg1)};
        let v8 = GlobalConfig{
            id       : 0x2::object::new(arg1),
            base_uri : 0x1::string::utf8(b"https://aggregator.walrus-mainnet.walrus.space/v1/blobs/"),
        };
        let v9 = MetadataRegistry{
            id                  : 0x2::object::new(arg1),
            current_amounts     : 0x2::table::new<0x2::object::ID, 0x1::string::String>(arg1),
            additional_metadata : 0x2::table::new<0x2::object::ID, 0x2::table::Table<0x1::string::String, 0x1::string::String>>(arg1),
        };
        0x2::transfer::public_transfer<SwapMintCap>(v7, v0);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v1, v0);
        0x2::transfer::public_transfer<0x2::display::Display<AlkimiLegacyNFT>>(v6, v0);
        0x2::transfer::share_object<GlobalConfig>(v8);
        0x2::transfer::share_object<MetadataRegistry>(v9);
    }

    public fun mint_alkimi_legacy_nft(arg0: &SwapMintCap, arg1: address, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u8>, arg7: vector<u8>, arg8: vector<u8>, arg9: vector<u8>, arg10: vector<u8>, arg11: vector<u8>, arg12: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::string::utf8(arg3);
        assert!(!0x1::string::is_empty(&v0), 2);
        let v1 = AlkimiLegacyNFT{
            id            : 0x2::object::new(arg12),
            name          : 0x1::string::utf8(arg2),
            swapped_token : v0,
            user_address  : arg1,
            background    : 0x1::string::utf8(arg4),
            scales        : 0x1::string::utf8(arg5),
            clothes       : 0x1::string::utf8(arg6),
            head          : 0x1::string::utf8(arg7),
            mouth         : 0x1::string::utf8(arg8),
            eyes          : 0x1::string::utf8(arg9),
            hands         : 0x1::string::utf8(arg10),
            blob_id       : 0x1::string::utf8(arg11),
        };
        let v2 = AlkimiLegacyNFTMinted{
            nft_id         : 0x2::object::id<AlkimiLegacyNFT>(&v1),
            recipient      : arg1,
            swapped_amount : v0,
        };
        0x2::event::emit<AlkimiLegacyNFTMinted>(v2);
        0x2::transfer::transfer<AlkimiLegacyNFT>(v1, arg1);
    }

    public fun mouth(arg0: &AlkimiLegacyNFT) : 0x1::string::String {
        arg0.mouth
    }

    public fun name(arg0: &AlkimiLegacyNFT) : 0x1::string::String {
        arg0.name
    }

    public fun remove_custom_metadata(arg0: &SwapMintCap, arg1: &mut MetadataRegistry, arg2: 0x2::object::ID, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::string::utf8(arg3);
        if (!0x2::table::contains<0x2::object::ID, 0x2::table::Table<0x1::string::String, 0x1::string::String>>(&arg1.additional_metadata, arg2)) {
            return
        };
        let v1 = 0x2::table::borrow_mut<0x2::object::ID, 0x2::table::Table<0x1::string::String, 0x1::string::String>>(&mut arg1.additional_metadata, arg2);
        if (0x2::table::contains<0x1::string::String, 0x1::string::String>(v1, v0)) {
            0x2::table::remove<0x1::string::String, 0x1::string::String>(v1, v0);
        };
    }

    public fun remove_metadata(arg0: &mut 0x2::display::Display<AlkimiLegacyNFT>, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::display::remove<AlkimiLegacyNFT>(arg0, 0x1::string::utf8(arg1));
        0x2::display::update_version<AlkimiLegacyNFT>(arg0);
    }

    public fun scales(arg0: &AlkimiLegacyNFT) : 0x1::string::String {
        arg0.scales
    }

    public fun swapped_amount(arg0: &AlkimiLegacyNFT, arg1: &MetadataRegistry) : 0x1::string::String {
        let v0 = 0x2::object::id<AlkimiLegacyNFT>(arg0);
        if (0x2::table::contains<0x2::object::ID, 0x1::string::String>(&arg1.current_amounts, v0)) {
            *0x2::table::borrow<0x2::object::ID, 0x1::string::String>(&arg1.current_amounts, v0)
        } else {
            arg0.swapped_token
        }
    }

    public fun update_base_uri(arg0: &SwapMintCap, arg1: &mut GlobalConfig, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.base_uri = 0x1::string::utf8(arg2);
    }

    public fun update_metadata(arg0: &mut 0x2::display::Display<AlkimiLegacyNFT>, arg1: vector<u8>, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::display::edit<AlkimiLegacyNFT>(arg0, 0x1::string::utf8(arg1), 0x1::string::utf8(arg2));
        0x2::display::update_version<AlkimiLegacyNFT>(arg0);
    }

    public fun update_swapped_amount(arg0: &SwapMintCap, arg1: &mut MetadataRegistry, arg2: 0x2::object::ID, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::string::utf8(arg3);
        assert!(!0x1::string::is_empty(&v0), 2);
        let v1 = if (0x2::table::contains<0x2::object::ID, 0x1::string::String>(&arg1.current_amounts, arg2)) {
            *0x2::table::borrow<0x2::object::ID, 0x1::string::String>(&arg1.current_amounts, arg2)
        } else {
            0x1::string::utf8(b"original")
        };
        if (0x2::table::contains<0x2::object::ID, 0x1::string::String>(&arg1.current_amounts, arg2)) {
            0x2::table::remove<0x2::object::ID, 0x1::string::String>(&mut arg1.current_amounts, arg2);
        };
        0x2::table::add<0x2::object::ID, 0x1::string::String>(&mut arg1.current_amounts, arg2, v0);
        let v2 = AmountUpdated{
            nft_id     : arg2,
            old_amount : v1,
            new_amount : v0,
            updated_by : 0x2::tx_context::sender(arg4),
        };
        0x2::event::emit<AmountUpdated>(v2);
    }

    public fun user_address(arg0: &AlkimiLegacyNFT) : address {
        arg0.user_address
    }

    // decompiled from Move bytecode v6
}

