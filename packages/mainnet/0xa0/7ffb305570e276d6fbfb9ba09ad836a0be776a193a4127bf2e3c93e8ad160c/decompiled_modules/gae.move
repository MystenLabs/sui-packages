module 0xa07ffb305570e276d6fbfb9ba09ad836a0be776a193a4127bf2e3c93e8ad160c::gae {
    struct GAE has drop {
        dummy_field: bool,
    }

    fun init(arg0: GAE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GAE>(arg0, 6, b"GAE", b"Pepe Julian Onzima", x"436f6d6d756e69747920636f696e2064656469636174656420746f2d200a0a4f6e65206f662074686520474145207269676874732061637469766973742c204d69737461682050657065204a756c69616e204f6e7a696d61200a0a5741524e494e47204f776e696e6720746f6b656e73206d6967687420636f6e7472696275746520746f2074686520706f73736962696c697479206f66206265636f6d652074686520474145", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/GAE_0704a0d8f9.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GAE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GAE>>(v1);
    }

    // decompiled from Move bytecode v6
}

