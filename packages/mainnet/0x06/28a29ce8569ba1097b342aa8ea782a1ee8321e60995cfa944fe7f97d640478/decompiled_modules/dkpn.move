module 0x628a29ce8569ba1097b342aa8ea782a1ee8321e60995cfa944fe7f97d640478::dkpn {
    struct DKPN has drop {
        dummy_field: bool,
    }

    fun init(arg0: DKPN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DKPN>(arg0, 9, b"DKPN", b"DEKOPON", b"Dekopon is a delicious citrus fruit that resembles a jelly that grows on a tree. It is grown in Kumamoto Prefecture, Japan.A distinctive feature of this fruit is that it has an upright stem.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/1272e4b8-c858-4840-b8d6-6a0155bfecbd.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DKPN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DKPN>>(v1);
    }

    // decompiled from Move bytecode v6
}

