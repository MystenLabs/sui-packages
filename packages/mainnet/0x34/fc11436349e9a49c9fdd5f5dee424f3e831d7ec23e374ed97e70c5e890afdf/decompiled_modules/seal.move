module 0x34fc11436349e9a49c9fdd5f5dee424f3e831d7ec23e374ed97e70c5e890afdf::seal {
    struct SEAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SEAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SEAL>(arg0, 9, b"SEAL", b"Neil the Seal", b"etohasnethusnao estnuahoesu thoaestu haosnethus naotheusa toheusao tehsu aotheusta hesnthu snoaethu snathoensu thaoesntu haostuh asnethu snaethu nsoaehtusnathus aoethus aoethusaon ethusta oehusnth aosntuh asnoethuaso ethusao ethusoa theusnaoh tesntuhaoe sutahoes uatheo us.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pump-fun-7k-dev.nysm.work/api/file-upload/281a0f7d36ba11ffc855ccb4454f92b0blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SEAL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SEAL>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

