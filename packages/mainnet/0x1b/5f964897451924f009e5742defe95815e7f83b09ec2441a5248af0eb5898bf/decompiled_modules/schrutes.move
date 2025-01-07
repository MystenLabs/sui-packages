module 0x1b5f964897451924f009e5742defe95815e7f83b09ec2441a5248af0eb5898bf::schrutes {
    struct SCHRUTES has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCHRUTES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCHRUTES>(arg0, 6, b"SCHRUTES", b"SCHRUTE BUCK", x"4e6f7468696e67206973207265616c6c792062657474657220666f72206d6f7469766174696f6e207468616e20726563696576696e6720612053636872757465204275636b2e205468697320746f6b656e20697320666f7220616c6c2077686f206c6f76657320616e642077616e7420746f2063656c65627261746520546865204f6666696365206d6f73742062656c6f766564206368617261637465722044776967687420536368727574652ec2a0", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1733057046827.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SCHRUTES>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCHRUTES>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

