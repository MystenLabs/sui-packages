module 0x55eeca6290519caae07e28ed616e5d86023439c2994ed275f67468cbe4a64e57::fle {
    struct FLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: FLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FLE>(arg0, 6, b"FLE", b"FleshSUI", b"i serve one master", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/st_H_Mob_W1_400x400_dc4e94128b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FLE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FLE>>(v1);
    }

    // decompiled from Move bytecode v6
}

