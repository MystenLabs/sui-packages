module 0xaa644104d5b63baf73e7f7a1148f7fb062f0e882862f01917b7be823426deb25::extension {
    struct TraceExt has drop {
        dummy_field: bool,
    }

    public fun lock<T0: store + key>(arg0: &0xaa644104d5b63baf73e7f7a1148f7fb062f0e882862f01917b7be823426deb25::access_control::AuthorizationProof<T0>, arg1: &0xaa644104d5b63baf73e7f7a1148f7fb062f0e882862f01917b7be823426deb25::access_control::Registry, arg2: &mut 0x2::kiosk::Kiosk, arg3: T0, arg4: &0x2::transfer_policy::TransferPolicy<T0>) {
        assert!(0xaa644104d5b63baf73e7f7a1148f7fb062f0e882862f01917b7be823426deb25::access_control::is_valid_version(arg1), 0);
        let v0 = TraceExt{dummy_field: false};
        0x2::kiosk_extension::lock<TraceExt, T0>(v0, arg2, arg3, arg4);
    }

    public fun place<T0: store + key>(arg0: &0xaa644104d5b63baf73e7f7a1148f7fb062f0e882862f01917b7be823426deb25::access_control::AuthorizationProof<T0>, arg1: &0xaa644104d5b63baf73e7f7a1148f7fb062f0e882862f01917b7be823426deb25::access_control::Registry, arg2: &mut 0x2::kiosk::Kiosk, arg3: T0, arg4: &0x2::transfer_policy::TransferPolicy<T0>) {
        assert!(0xaa644104d5b63baf73e7f7a1148f7fb062f0e882862f01917b7be823426deb25::access_control::is_valid_version(arg1), 0);
        let v0 = TraceExt{dummy_field: false};
        0x2::kiosk_extension::place<TraceExt, T0>(v0, arg2, arg3, arg4);
    }

    public fun install(arg0: &0xaa644104d5b63baf73e7f7a1148f7fb062f0e882862f01917b7be823426deb25::access_control::Registry, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0xaa644104d5b63baf73e7f7a1148f7fb062f0e882862f01917b7be823426deb25::access_control::is_valid_version(arg0), 0);
        let v0 = TraceExt{dummy_field: false};
        0x2::kiosk_extension::add<TraceExt>(v0, arg1, arg2, 2, arg3);
    }

    // decompiled from Move bytecode v6
}

