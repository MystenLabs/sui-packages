module 0x58eb84b36eaa3228d674ffd980b98bb58650355947a1a7a51fbf32ac24cafdaf::tny {
    struct TNY has drop {
        dummy_field: bool,
    }

    fun init(arg0: TNY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TNY>(arg0, 9, b"TNY", b"Tony", b"Based on tony bridge's bot on telegram", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/9fc60edc-a993-4e68-bb60-babc199c365b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TNY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TNY>>(v1);
    }

    // decompiled from Move bytecode v6
}

