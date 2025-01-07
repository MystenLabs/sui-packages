module 0xe611073d8c464294c27486f26e0550651cb9641a1fb9b6a3da7f1938b65525e0::say5wat {
    struct SAY5WAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAY5WAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SAY5WAT>(arg0, 9, b"SAY5WAT", b"Lolo", b"Hop to the moon...say wat? ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/9d370bc1-98c7-4ab3-99e5-e5e7aaa20216.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAY5WAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SAY5WAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

