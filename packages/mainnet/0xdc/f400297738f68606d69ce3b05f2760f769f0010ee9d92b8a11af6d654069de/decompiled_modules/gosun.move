module 0xdcf400297738f68606d69ce3b05f2760f769f0010ee9d92b8a11af6d654069de::gosun {
    struct GOSUN has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOSUN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOSUN>(arg0, 6, b"GOSUN", b"GUARDIAN OF SUN", b"We moving to SUI. GOSUN aims to preserve, celebrate, and collaborate the creative and cultural phenomenon of memes on SUI. Original OGs here. 888.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_08_27_00_22_11_f096be440d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOSUN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GOSUN>>(v1);
    }

    // decompiled from Move bytecode v6
}

