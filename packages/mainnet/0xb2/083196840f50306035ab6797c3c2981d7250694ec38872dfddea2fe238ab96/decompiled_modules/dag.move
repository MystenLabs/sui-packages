module 0xb2083196840f50306035ab6797c3c2981d7250694ec38872dfddea2fe238ab96::dag {
    struct DAG has drop {
        dummy_field: bool,
    }

    fun init(arg0: DAG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DAG>(arg0, 6, b"DaG", b"Dog & Banana", b"literally just a dog wears banana", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://tomato-deep-eel-22.mypinata.cloud/ipfs/QmXfzwWvDGtowt7vNCZgkEPErUNA4vi1LcVvwg3AJQvgSq")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<DAG>(&mut v2, 8000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DAG>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DAG>>(v1);
    }

    // decompiled from Move bytecode v6
}

