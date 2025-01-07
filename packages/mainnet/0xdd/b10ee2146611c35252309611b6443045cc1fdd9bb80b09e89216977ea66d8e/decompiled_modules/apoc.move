module 0xddb10ee2146611c35252309611b6443045cc1fdd9bb80b09e89216977ea66d8e::apoc {
    struct APOC has drop {
        dummy_field: bool,
    }

    fun init(arg0: APOC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<APOC>(arg0, 9, b"Apoc", b"Apocalypse", b"Apocalypse approaching from infinite angles, all roads leading to the revelation.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<APOC>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<APOC>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<APOC>>(v1);
    }

    // decompiled from Move bytecode v6
}

