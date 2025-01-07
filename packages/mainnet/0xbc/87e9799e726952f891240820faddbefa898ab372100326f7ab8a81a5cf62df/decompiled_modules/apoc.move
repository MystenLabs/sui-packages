module 0xbc87e9799e726952f891240820faddbefa898ab372100326f7ab8a81a5cf62df::apoc {
    struct APOC has drop {
        dummy_field: bool,
    }

    fun init(arg0: APOC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<APOC>(arg0, 9, b"APOC", b"Apocalypse", b"Safe the World ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/76874283-5fab-4953-83a0-53aff231f907.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<APOC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<APOC>>(v1);
    }

    // decompiled from Move bytecode v6
}

