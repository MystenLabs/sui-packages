module 0xc8787c779badb0d84d5df64a10434c4699ad64072a1f6a94524784ac864c234a::mt {
    struct MT has drop {
        dummy_field: bool,
    }

    fun init(arg0: MT, arg1: &mut 0x2::tx_context::TxContext) {
        0xde1daed592bf5c80c0f177e803768f7dad17bc7d1fff1265d4affaabea9f7950::mtoken::create_coin<MT>(arg0, 9, b"MT", b"MT", b"MT", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://app.matrixdock.com/images/xaum/xaum-64x64-icon.png")), true, 0, arg1);
    }

    // decompiled from Move bytecode v6
}

