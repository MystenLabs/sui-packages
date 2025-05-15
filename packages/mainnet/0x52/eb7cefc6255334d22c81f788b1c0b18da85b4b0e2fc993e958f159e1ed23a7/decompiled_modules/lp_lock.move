module 0x52eb7cefc6255334d22c81f788b1c0b18da85b4b0e2fc993e958f159e1ed23a7::lp_lock {
    struct CetusLPLocked<T0: store + key> has store, key {
        id: 0x2::object::UID,
        nft: 0x1::option::Option<T0>,
        owner: address,
        lock_time: u64,
        name: 0x1::string::String,
        url: 0x2::url::Url,
    }

    public fun url<T0: store + key>(arg0: &CetusLPLocked<T0>) : &0x2::url::Url {
        &arg0.url
    }

    public fun lock_lp<T0: store + key>(arg0: T0, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : CetusLPLocked<T0> {
        assert!(arg1 > 0, 0);
        CetusLPLocked<T0>{
            id        : 0x2::object::new(arg2),
            nft       : 0x1::option::some<T0>(arg0),
            owner     : 0x2::tx_context::sender(arg2),
            lock_time : arg1,
            name      : 0x1::string::utf8(b"Cetus LP Locked"),
            url       : 0x2::url::new_unsafe_from_bytes(b"https://92ba31ccd969233e49d859b38fd4603f.ipfscdn.io/ipfs/bafybeigb7f7qehyvyav5j67zup5ovnc5yd3kq35r64n2spe7vjex46xqwq/0"),
        }
    }

    public fun name<T0: store + key>(arg0: &CetusLPLocked<T0>) : &0x1::string::String {
        &arg0.name
    }

    public fun unlock_lp<T0: store + key>(arg0: CetusLPLocked<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::clock::timestamp_ms(arg1);
        let CetusLPLocked {
            id        : v0,
            nft       : v1,
            owner     : v2,
            lock_time : _,
            name      : _,
            url       : _,
        } = arg0;
        assert!(v2 == 0x2::tx_context::sender(arg2), 1);
        0x2::transfer::public_transfer<T0>(0x1::option::destroy_some<T0>(v1), v2);
        0x2::object::delete(v0);
    }

    // decompiled from Move bytecode v6
}

