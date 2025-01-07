module 0x668336777282cf028895d1c2694eeb039c5520ddc10bdfefc0bfcaa94699bb48::ngah_wewe {
    struct NGAH_WEWE has drop {
        dummy_field: bool,
    }

    fun init(arg0: NGAH_WEWE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NGAH_WEWE>(arg0, 9, b"NGAH_WEWE", b"Ngah", b"Just ngah", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/23b38466-cdfc-4496-b296-a537539ce7dc.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NGAH_WEWE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NGAH_WEWE>>(v1);
    }

    // decompiled from Move bytecode v6
}

