module 0x8c220f8b65669088904ac86b9f4b5a3f773b195b64f48c814641f92916ac188b::vtll {
    struct VTLL has drop {
        dummy_field: bool,
    }

    fun init(arg0: VTLL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VTLL>(arg0, 9, b"VTLL", b"vitalii29", b"cryptooo", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/4a90b216219543986b11eee51bb7c99fblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<VTLL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VTLL>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

