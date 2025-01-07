module 0x6d3193edad3d88077159ff2958da441d90af516bc5fe3bbb26310868a3fd8864::kjy {
    struct KJY has drop {
        dummy_field: bool,
    }

    fun init(arg0: KJY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KJY>(arg0, 9, b"KJY", b"Kojaywow", b"Channel Cryptocurrency", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/8d6db098-d792-48b7-a50c-ac9ae4ce7116.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KJY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KJY>>(v1);
    }

    // decompiled from Move bytecode v6
}

