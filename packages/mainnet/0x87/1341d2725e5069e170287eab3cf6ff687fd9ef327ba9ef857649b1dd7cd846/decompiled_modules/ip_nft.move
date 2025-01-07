module 0x871341d2725e5069e170287eab3cf6ff687fd9ef327ba9ef857649b1dd7cd846::ip_nft {
    struct EuterpeIPNFT has store, key {
        id: 0x2::object::UID,
        token_id: u256,
        amount: u256,
        name: 0x1::string::String,
        image_url: 0x2::url::Url,
    }

    struct IP_NFT has drop {
        dummy_field: bool,
    }

    struct MintEvent has copy, drop {
        object_id: 0x2::object::ID,
        token_id: u256,
        amount: u256,
        account: address,
    }

    struct BurnEvent has copy, drop {
        object_id: 0x2::object::ID,
        token_id: u256,
        amount: u256,
        account: address,
    }

    public entry fun burn(arg0: EuterpeIPNFT, arg1: &mut 0x2::tx_context::TxContext) {
        let EuterpeIPNFT {
            id        : v0,
            token_id  : v1,
            amount    : v2,
            name      : _,
            image_url : _,
        } = arg0;
        let v5 = v0;
        let v6 = BurnEvent{
            object_id : 0x2::object::uid_to_inner(&v5),
            token_id  : v1,
            amount    : v2,
            account   : 0x2::tx_context::sender(arg1),
        };
        0x2::event::emit<BurnEvent>(v6);
        0x2::object::delete(v5);
    }

    fun decrease_amount(arg0: &mut EuterpeIPNFT, arg1: u256) {
        assert!(arg0.amount > arg1, 1);
        arg0.amount = arg0.amount - arg1;
    }

    public fun get_amount(arg0: &EuterpeIPNFT) : u256 {
        arg0.amount
    }

    public fun get_image_url(arg0: &EuterpeIPNFT) : 0x2::url::Url {
        arg0.image_url
    }

    public fun get_name(arg0: &EuterpeIPNFT) : 0x1::string::String {
        arg0.name
    }

    public fun get_token_id(arg0: &EuterpeIPNFT) : u256 {
        arg0.token_id
    }

    fun increase_amount(arg0: &mut EuterpeIPNFT, arg1: u256) {
        arg0.amount = arg0.amount + arg1;
    }

    fun init(arg0: IP_NFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<IP_NFT>(arg0, arg1);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<EuterpeIPNFT>>(0x2::display::new<EuterpeIPNFT>(&v0, arg1), 0x2::tx_context::sender(arg1));
    }

    public entry fun merge(arg0: &mut EuterpeIPNFT, arg1: vector<EuterpeIPNFT>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::length<EuterpeIPNFT>(&arg1);
        assert!(v0 > 0, 2);
        let v1 = 0;
        let v2 = 0;
        while (v2 < v0) {
            let EuterpeIPNFT {
                id        : v3,
                token_id  : v4,
                amount    : v5,
                name      : _,
                image_url : _,
            } = 0x1::vector::remove<EuterpeIPNFT>(&mut arg1, 0);
            assert!(v4 == arg0.token_id, 3);
            v1 = v1 + v5;
            0x2::object::delete(v3);
            v2 = v2 + 1;
        };
        0x1::vector::destroy_empty<EuterpeIPNFT>(arg1);
        increase_amount(arg0, v1);
    }

    public entry fun mint(arg0: &0x871341d2725e5069e170287eab3cf6ff687fd9ef327ba9ef857649b1dd7cd846::capabilities::OwnerCap, arg1: u256, arg2: u256, arg3: vector<u8>, arg4: vector<u8>, arg5: address, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 > 0, 0);
        mint_internal(arg1, arg2, arg3, arg4, arg5, arg6);
    }

    fun mint_internal(arg0: u256, arg1: u256, arg2: vector<u8>, arg3: vector<u8>, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = EuterpeIPNFT{
            id        : 0x2::object::new(arg5),
            token_id  : arg0,
            amount    : arg1,
            name      : 0x1::string::utf8(arg2),
            image_url : 0x2::url::new_unsafe_from_bytes(arg3),
        };
        let v1 = MintEvent{
            object_id : 0x2::object::uid_to_inner(&v0.id),
            token_id  : arg0,
            amount    : arg1,
            account   : arg4,
        };
        0x2::event::emit<MintEvent>(v1);
        0x2::transfer::transfer<EuterpeIPNFT>(v0, arg4);
    }

    public entry fun mint_multi(arg0: &0x871341d2725e5069e170287eab3cf6ff687fd9ef327ba9ef857649b1dd7cd846::capabilities::OwnerCap, arg1: u256, arg2: u256, arg3: vector<u8>, arg4: vector<u8>, arg5: address, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 > 0, 0);
        let v0 = 0;
        while (v0 < arg2) {
            mint_internal(arg1, 1, arg3, arg4, arg5, arg6);
            v0 = v0 + 1;
        };
    }

    public entry fun split(arg0: &mut EuterpeIPNFT, arg1: u256, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 > 0, 0);
        decrease_amount(arg0, arg1);
        let v0 = EuterpeIPNFT{
            id        : 0x2::object::new(arg2),
            token_id  : arg0.token_id,
            amount    : arg1,
            name      : arg0.name,
            image_url : arg0.image_url,
        };
        0x2::transfer::transfer<EuterpeIPNFT>(v0, 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}

