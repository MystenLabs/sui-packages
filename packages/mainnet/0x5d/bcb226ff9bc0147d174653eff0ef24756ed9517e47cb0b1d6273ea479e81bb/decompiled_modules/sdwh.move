module 0x5dbcb226ff9bc0147d174653eff0ef24756ed9517e47cb0b1d6273ea479e81bb::sdwh {
    struct SDWH has drop {
        dummy_field: bool,
    }

    fun init(arg0: SDWH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SDWH>(arg0, 6, b"SDWH", b"SUIdogwifhat", x"427579206120626c756520646f6777696668617420746f20737570706f72742074686520636f6d6d756e697479206f6620746865206c6567656e6461727920646f672e0a2453445748", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/suidwh_4985a55187.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SDWH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SDWH>>(v1);
    }

    // decompiled from Move bytecode v6
}

