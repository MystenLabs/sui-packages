module 0x608b1f881e970fd8d351286da99f1cb02fde42e4afd326e988c0945cbaef1f11::holym {
    struct HOLYM has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOLYM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOLYM>(arg0, 9, b"HOLYM", b"Holymeme", b"A memecoin created solely for the fun of it", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/9a8b14b7-a2be-47a4-a8ec-665c7d355125.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOLYM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HOLYM>>(v1);
    }

    // decompiled from Move bytecode v6
}

