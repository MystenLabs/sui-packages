module 0xaff835f702700ad73bdbc5249016af2066a20045c44b17b6c0d45d104fb785f6::bam {
    struct BAM has drop {
        dummy_field: bool,
    }

    fun init(arg0: BAM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BAM>(arg0, 9, b"BAM", b"BAD MAN", b"DEVIL MAN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/1aec6491-4ea2-4a3c-9b5c-76d55e3c0d91.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BAM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BAM>>(v1);
    }

    // decompiled from Move bytecode v6
}

