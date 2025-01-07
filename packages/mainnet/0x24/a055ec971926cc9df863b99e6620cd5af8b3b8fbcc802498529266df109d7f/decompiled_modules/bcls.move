module 0x24a055ec971926cc9df863b99e6620cd5af8b3b8fbcc802498529266df109d7f::bcls {
    struct BCLS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BCLS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BCLS>(arg0, 9, b"BCLS", b"Bacillus", b"Bacillus (BCLS) is a unique cryptocurrency designed with a focus on decentralized finance (DeFi) ecosystems.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c1688569-ba3f-4ffa-95b6-89a57d0af4e3.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BCLS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BCLS>>(v1);
    }

    // decompiled from Move bytecode v6
}

