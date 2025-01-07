module 0x62b92f010226581a5355bb7a6afd71f68d3423b36ef0ad900c9a8688ebd7cd58::sam {
    struct SAM has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SAM>(arg0, 9, b"SAM", b"vann samba", b"gooodd coll", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/97458ca4-db15-4db8-8ce4-84ac3df82289.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SAM>>(v1);
    }

    // decompiled from Move bytecode v6
}

