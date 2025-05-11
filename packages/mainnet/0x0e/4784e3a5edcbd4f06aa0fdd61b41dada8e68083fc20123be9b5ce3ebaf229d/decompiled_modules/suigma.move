module 0xe4784e3a5edcbd4f06aa0fdd61b41dada8e68083fc20123be9b5ce3ebaf229d::suigma {
    struct SUIGMA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIGMA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIGMA>(arg0, 6, b"SUIGMA", b"Sigma on Sui", b"Are you swimming with the sharks or drifting with the minnows?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreifow6zy5yja6qua623acpcb4dcbh3tled3oq2oj5detyotbt63bv4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIGMA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUIGMA>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

