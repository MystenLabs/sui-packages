module 0x1edc0a5694221f871051d3f6af54dbc0f4d89e40f0cbd65b63c71fc0c780ecb6::cof {
    struct COF has drop {
        dummy_field: bool,
    }

    fun init(arg0: COF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COF>(arg0, 9, b"COF", b"Stone Age coffee", b"A cup of coffee in the time of the Flintstones", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/7090f6ceb9bc82203b1e889035629e30blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<COF>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COF>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

