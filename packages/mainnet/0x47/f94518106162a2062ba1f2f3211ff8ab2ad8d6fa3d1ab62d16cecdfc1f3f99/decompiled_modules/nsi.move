module 0x47f94518106162a2062ba1f2f3211ff8ab2ad8d6fa3d1ab62d16cecdfc1f3f99::nsi {
    struct NSI has drop {
        dummy_field: bool,
    }

    fun init(arg0: NSI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NSI>(arg0, 9, b"NSI", b"Notsui", b"Notsui not pixel", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/da12e3c6-5773-4b36-890a-61c236bfb380.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NSI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NSI>>(v1);
    }

    // decompiled from Move bytecode v6
}

