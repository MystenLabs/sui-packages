module 0xc674e71dfc483696badb4c3975bc4e6a83a472d508cf351be89cf0f717fe202e::scps {
    struct SCPS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCPS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCPS>(arg0, 9, b"SCPS", b"SCALLOPS", b"Dive into delicious gains", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d260e697-1731-4267-a73d-3bdb10168c5d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCPS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SCPS>>(v1);
    }

    // decompiled from Move bytecode v6
}

