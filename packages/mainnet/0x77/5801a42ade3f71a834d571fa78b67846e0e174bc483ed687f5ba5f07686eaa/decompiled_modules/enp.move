module 0x775801a42ade3f71a834d571fa78b67846e0e174bc483ed687f5ba5f07686eaa::enp {
    struct ENP has drop {
        dummy_field: bool,
    }

    fun init(arg0: ENP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ENP>(arg0, 9, b"ENP", b"Endorphin", b"9", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/43219332-a96b-493c-8d31-99643ac495da.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ENP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ENP>>(v1);
    }

    // decompiled from Move bytecode v6
}

