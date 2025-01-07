module 0xc733d3030a016a25178c1562828884c0b1a82db810b2ec2c4d980724ebf8d839::suinic {
    struct SUINIC has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUINIC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUINIC>(arg0, 6, b"SUINIC", b"Suinic", x"496e73706972656420627920746865206c6567656e6461727920536f6e69632c205375696e696320697320737769667420616e642066756c6c206f6620656e657267792c207370656564696e67207468726f75676820626c6f636b7320616e64207472616e73616374696f6e732e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730960182943.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUINIC>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUINIC>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

