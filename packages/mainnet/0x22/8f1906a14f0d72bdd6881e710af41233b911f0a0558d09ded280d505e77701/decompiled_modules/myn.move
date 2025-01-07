module 0x228f1906a14f0d72bdd6881e710af41233b911f0a0558d09ded280d505e77701::myn {
    struct MYN has drop {
        dummy_field: bool,
    }

    fun init(arg0: MYN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MYN>(arg0, 9, b"MYN", b"MINIYO", b"OUR SPACE PRICE MINIONS ARE SURISED", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/916ddc07-6223-4224-9fa1-b13029a7cb88.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MYN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MYN>>(v1);
    }

    // decompiled from Move bytecode v6
}

