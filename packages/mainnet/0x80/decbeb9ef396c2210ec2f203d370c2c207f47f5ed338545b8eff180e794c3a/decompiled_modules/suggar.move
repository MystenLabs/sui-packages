module 0x80decbeb9ef396c2210ec2f203d370c2c207f47f5ed338545b8eff180e794c3a::suggar {
    struct SUGGAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUGGAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUGGAR>(arg0, 6, b"SUGGAR", b"Sugggar", b"buy mi dog suggar", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/mi_dog_in_fuckin_sui_471acc7d45.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUGGAR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUGGAR>>(v1);
    }

    // decompiled from Move bytecode v6
}

