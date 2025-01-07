module 0xc363ca2281b2582d79775a5464ec79865490cf74c7355e1882937bc87f833f87::suiderman {
    struct SUIDERMAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIDERMAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIDERMAN>(arg0, 6, b"Suiderman", b"SUIDERMAN", b"Suiderman is a hero from the Pacific Ocean who will help anyone who is in trouble. suiderman will attack all the dangers that come and also eradicate all the evil that exists in the world ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/bawang_goreng_20241006_090250_0000_fdadcaf9df.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIDERMAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIDERMAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

