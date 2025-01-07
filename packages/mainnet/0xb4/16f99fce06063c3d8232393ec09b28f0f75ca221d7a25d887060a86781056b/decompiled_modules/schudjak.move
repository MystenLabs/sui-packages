module 0xb416f99fce06063c3d8232393ec09b28f0f75ca221d7a25d887060a86781056b::schudjak {
    struct SCHUDJAK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCHUDJAK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCHUDJAK>(arg0, 6, b"SCHUDJAK", b"Sui Chudjak", x"50617274204c6174696e6f2c20506f6c6973682c0a47726f7465737175656c6c61746f2c0a41626f6d696e61626f726967696e65652c204765726d616e2c0a57656c73682c204d616c666f726d696e6f20616e642042656c6769616e0a6275742076696f6c656e746c7920646973747572626564207768656e0a7468696e6b696e672061626f75742070726573657276696e67207468650a577974652072616365", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_a68e876057.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCHUDJAK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SCHUDJAK>>(v1);
    }

    // decompiled from Move bytecode v6
}

