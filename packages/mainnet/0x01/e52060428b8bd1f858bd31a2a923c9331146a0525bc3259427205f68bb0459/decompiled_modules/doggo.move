module 0x1e52060428b8bd1f858bd31a2a923c9331146a0525bc3259427205f68bb0459::doggo {
    struct DOGGO has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGGO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGGO>(arg0, 6, b"DOGGO", b"doggo", b"gogo doggo ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"http://movepump.xyz/uploads/rocket_a71f724a1a.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGGO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOGGO>>(v1);
    }

    // decompiled from Move bytecode v6
}

