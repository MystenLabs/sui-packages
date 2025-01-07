module 0xc7bf23fce582ed2d37db9b569983eccea21fb22474de25403c70ce39d25786fc::nrn {
    struct NRN has drop {
        dummy_field: bool,
    }

    fun init(arg0: NRN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NRN>(arg0, 6, b"NRN", b"NEURON", b"Neuron (NRN) is a utility and governance token powering a decentralized AI ecosystem, enabling access to premium AI services, voting rights, and staking rewards. NRN supports project funding, model sharing, and collaborative AI research in a secure, ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731516944034.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NRN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NRN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

