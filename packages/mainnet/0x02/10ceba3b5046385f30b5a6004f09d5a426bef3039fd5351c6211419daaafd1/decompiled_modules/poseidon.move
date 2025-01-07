module 0x210ceba3b5046385f30b5a6004f09d5a426bef3039fd5351c6211419daaafd1::poseidon {
    struct POSEIDON has drop {
        dummy_field: bool,
    }

    fun init(arg0: POSEIDON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POSEIDON>(arg0, 6, b"POSEIDON", b"Poseidon", b"Poseidon is here to claim his rightful throne as the God of the Sui. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/poseidon_0c43b1483e.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POSEIDON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POSEIDON>>(v1);
    }

    // decompiled from Move bytecode v6
}

