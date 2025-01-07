module 0x67ee3e2225f95492a61c7df7fc3df2836d1395136469ed17dab2cafdd579fd2f::ponsui {
    struct PONSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PONSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PONSUI>(arg0, 9, b"PONSUI", b"PonSUI", b"PonSUI is a community-memecoin on @SuiNetwork that blends humor, the desire for wealth, and the blockchain world!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f4f5f8e3-c4c3-4134-a3e5-49b3e334dcda.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PONSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PONSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

