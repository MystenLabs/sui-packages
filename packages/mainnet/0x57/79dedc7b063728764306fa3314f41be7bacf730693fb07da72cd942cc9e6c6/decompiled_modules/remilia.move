module 0x5779dedc7b063728764306fa3314f41be7bacf730693fb07da72cd942cc9e6c6::remilia {
    struct REMILIA has drop {
        dummy_field: bool,
    }

    fun init(arg0: REMILIA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<REMILIA>(arg0, 9, b"Remilia", b"Remilia", b"Community Claim Dev is nowhere to be found community has taken over made a new telegram and twitter account", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://teal-deliberate-skunk-670.mypinata.cloud/ipfs/QmcrHtGatQmZeqdE749A3W3Ym587wGEp9hdEuHq7GKboup")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<REMILIA>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<REMILIA>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<REMILIA>>(v1);
    }

    // decompiled from Move bytecode v6
}

