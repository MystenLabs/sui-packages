module 0x665385975632c045920bd2e3e87b5dd229f44941060582d3d145c4b3da12c004::boo {
    struct BOO has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOO>(arg0, 6, b"BOO", b"BOO On Sui Ghost", b"Your friendly SUI phantom that scares the shit out of jeets", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ovmon_045f384f3f_2c328a4cce.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOO>>(v1);
    }

    // decompiled from Move bytecode v6
}

