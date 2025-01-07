module 0xd1451725647c969c382f45e1a52f9e51e96f986b45ef27306f3ae13362b37d29::ssj {
    struct SSJ has drop {
        dummy_field: bool,
    }

    fun init(arg0: SSJ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SSJ>(arg0, 9, b"SSJ", b"Serjsnt", b"Good token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/4eb036a6-3429-4e68-96a9-4e61c28aa739.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SSJ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SSJ>>(v1);
    }

    // decompiled from Move bytecode v6
}

