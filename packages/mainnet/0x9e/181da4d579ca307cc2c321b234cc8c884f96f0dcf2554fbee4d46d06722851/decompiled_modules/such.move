module 0x9e181da4d579ca307cc2c321b234cc8c884f96f0dcf2554fbee4d46d06722851::such {
    struct SUCH has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUCH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUCH>(arg0, 9, b"SUCH", b"SUCH", b"YouTube", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.ytimg.com/vi/m-x1BYPWRyY/maxresdefault.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUCH>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUCH>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUCH>>(v1);
    }

    // decompiled from Move bytecode v6
}

