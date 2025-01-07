module 0x9d41e1afea1c517da941d608d85fff463f1d2e44efc228ab634ffa942c39bb4f::aqua {
    struct AQUA has drop {
        dummy_field: bool,
    }

    fun init(arg0: AQUA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AQUA>(arg0, 9, b"AQUA", b"Aqua", b"AQUA is the currency for rewards and on-chain voting in Aquarius. Holders of AQUA can vote for trusted assets issued on SUI Network.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/33c3f6b1-f783-4621-a309-9dbdcb6901db.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AQUA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AQUA>>(v1);
    }

    // decompiled from Move bytecode v6
}

