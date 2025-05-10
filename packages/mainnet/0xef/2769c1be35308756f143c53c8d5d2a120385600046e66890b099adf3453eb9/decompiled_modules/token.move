module 0xef2769c1be35308756f143c53c8d5d2a120385600046e66890b099adf3453eb9::token {
    struct TOKEN has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<TOKEN>, arg1: 0x2::coin::Coin<TOKEN>) {
        0x2::coin::burn<TOKEN>(arg0, arg1);
    }

    fun init(arg0: TOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOKEN>(arg0, 9, b"MeMe Coin", b"MeMeC", b"DESCRIPTION", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"http://node1.irys.xyz/Rp80fmqZS3qBDnfyxyKEvc65nVdTunjOG3NY8T6AjpI")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TOKEN>>(v1);
        0x2::coin::mint_and_transfer<TOKEN>(&mut v2, 1000000000000000000, @0xc1f65b01785528768f04b433ee2e272aafdf6150e79ce10a6afceea52f9f21c6, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOKEN>>(v2, @0xc1f65b01785528768f04b433ee2e272aafdf6150e79ce10a6afceea52f9f21c6);
    }

    // decompiled from Move bytecode v6
}

