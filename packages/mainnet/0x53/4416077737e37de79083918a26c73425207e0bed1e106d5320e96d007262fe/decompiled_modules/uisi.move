module 0x534416077737e37de79083918a26c73425207e0bed1e106d5320e96d007262fe::uisi {
    struct UISI has drop {
        dummy_field: bool,
    }

    fun init(arg0: UISI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UISI>(arg0, 9, b"UISI", b"UISI Cmpus", b"Top 1 campus in Gresik , under the auspices of BUMN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/547ee77d-774c-4396-9699-6cdb60f28ca7.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UISI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<UISI>>(v1);
    }

    // decompiled from Move bytecode v6
}

