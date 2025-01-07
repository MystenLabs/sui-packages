module 0x220832f19a127e89644dbcea8ffd09e84149f8311393305142efa76184cad6a6::SAT {
    struct SAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SAT>(arg0, 9, b"SAT", b"Seal Cat", b"Seal Soul, Cat Vibes", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://movepump.com/_next/image?url=https%3A%2F%2Fapi.movepump.com%2Fuploads%2Fphoto_2024_11_15_02_23_57_8eab845fda.jpg&w=256&q=75")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SAT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<SAT>>(0x2::coin::mint<SAT>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<SAT>>(v2);
    }

    // decompiled from Move bytecode v6
}

