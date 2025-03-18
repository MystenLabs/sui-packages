module 0xd9c43a24082dbcb044df1783d42d0ad05dc9447c856b269238ae653e931c99c1::pengu {
    struct PENGU has drop {
        dummy_field: bool,
    }

    fun init(arg0: PENGU, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::epoch(arg1) == 705 || 0x2::tx_context::epoch(arg1) == 706, 1);
        let (v0, v1) = 0x2::coin::create_currency<PENGU>(arg0, 9, b"PENGU", b"Pudgy Penguins", b"For the people. By the people.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://ko6tejzfueu6hdmt3gk7tfpmsriguun24hrrym46hhyw4h35mmya.arweave.net/U70yJyWhKeONk9mV-ZXslFBqUbrh4xwznjnxbh99YzA"))), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PENGU>(&mut v2, 8888888888000000000, @0x684de3a1e655c8361483b429189fd06df4fc5ca367a98fd461d84761da9e4bf3, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PENGU>>(v2, @0x684de3a1e655c8361483b429189fd06df4fc5ca367a98fd461d84761da9e4bf3);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PENGU>>(v1);
    }

    // decompiled from Move bytecode v6
}

