module 0x3a4b399e18cec6129723c71605378bd554f53eb63afc1039f9af9a067a8847fa::bucket {
    struct BUCKET has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUCKET, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x6104e610f707fe5f1b3f34aa274c113a6b0523e63d5fb2069710e1c2d1f1fd1c::de_center::AdminCap<BUCKET>>(0x6104e610f707fe5f1b3f34aa274c113a6b0523e63d5fb2069710e1c2d1f1fd1c::de_center::new_admin<BUCKET>(arg0, arg1), @0x19f528cf4b5d0d8bcbc33c66405d149ea726a4dc1bc773537dc65364d4e58be4);
    }

    // decompiled from Move bytecode v6
}

