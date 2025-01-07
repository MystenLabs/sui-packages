module 0x63855e1164f858c4ff711a36e56cccf84f1f43c628b0a877f6ac610fbce34f1f::say5wat {
    struct SAY5WAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAY5WAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SAY5WAT>(arg0, 9, b"SAY5WAT", b"Lolo", b"Hop to the moon...say wat? ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/46e18d8b-f971-437b-8ab9-ccf12356bada.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAY5WAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SAY5WAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

