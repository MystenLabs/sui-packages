module 0xa8258c64369df32f8a73dd7fcd778f8bd94758763dd091088f002d0ee823708e::slot {
    struct SLOT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SLOT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SLOT>(arg0, 9, b"SLOT", b"SLOT", b"LETs play together", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://st.depositphotos.com/1028367/2576/v/450/depositphotos_25761829-stock-illustration-a-vector-slot-fruit-machine.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SLOT>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SLOT>>(v2, @0x51bc74eda8ab48e3c07b1aaf855540f1d2f46b779a2d2577b2bc74a0e3257350);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SLOT>>(v1);
    }

    // decompiled from Move bytecode v6
}

