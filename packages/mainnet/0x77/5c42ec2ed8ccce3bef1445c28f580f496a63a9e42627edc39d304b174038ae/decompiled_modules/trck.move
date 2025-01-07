module 0x775c42ec2ed8ccce3bef1445c28f580f496a63a9e42627edc39d304b174038ae::trck {
    struct TRCK has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRCK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRCK>(arg0, 9, b"TRCK", b"Truck", b"Truck drivers token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/bf47ea86-2403-4805-8f75-b14dcaa88542.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRCK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TRCK>>(v1);
    }

    // decompiled from Move bytecode v6
}

