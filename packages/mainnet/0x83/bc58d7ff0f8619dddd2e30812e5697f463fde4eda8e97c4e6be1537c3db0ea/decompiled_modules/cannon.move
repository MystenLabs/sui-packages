module 0x83bc58d7ff0f8619dddd2e30812e5697f463fde4eda8e97c4e6be1537c3db0ea::cannon {
    struct CANNON has drop {
        dummy_field: bool,
    }

    fun init(arg0: CANNON, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<CANNON>(arg0, 3, b"CANNON", b"CANNON", b"CANNON is a coin for the CANNON project", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.ibb.co/d7cFZXt/portomasonet.png")), arg1);
        let v3 = v1;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CANNON>>(v2);
        0x2::coin::mint_and_transfer<CANNON>(&mut v3, 900000000000000000, v0, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CANNON>>(v3, v0);
    }

    // decompiled from Move bytecode v6
}

