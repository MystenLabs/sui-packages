module 0x22f303013c5e009271e06ea2ec8c656d0ac04256dd81bee2d948eac912c2e2a3::sissi {
    struct SISSI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SISSI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SISSI>(arg0, 6, b"SISSI", b"Sissi", b"Hi, I am Sissi, the cat on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2024_09_19_150744_d368a63b34.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SISSI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SISSI>>(v1);
    }

    // decompiled from Move bytecode v6
}

