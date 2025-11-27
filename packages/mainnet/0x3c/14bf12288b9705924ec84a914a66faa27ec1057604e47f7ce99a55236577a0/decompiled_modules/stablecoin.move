module 0x3c14bf12288b9705924ec84a914a66faa27ec1057604e47f7ce99a55236577a0::stablecoin {
    struct STABLECOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: STABLECOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, _) = 0xbd4c85cadfe1b0ff08ee8f32a2f9bafc3936c0e2e4f70ac3c8efb76a060bccbb::upgrade_service::new<STABLECOIN>(arg0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_share_object<0xbd4c85cadfe1b0ff08ee8f32a2f9bafc3936c0e2e4f70ac3c8efb76a060bccbb::upgrade_service::UpgradeService<STABLECOIN>>(v0);
    }

    // decompiled from Move bytecode v6
}

