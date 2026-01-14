module 0x6db226dfc4db6cd271c79ea7558968419511ee27b0adfaa73dad7c31bcd311f7::leverage_admin {
    public fun inject_protocol_caller_cap(arg0: &0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::app::AdminCap, arg1: &mut 0x6db226dfc4db6cd271c79ea7558968419511ee27b0adfaa73dad7c31bcd311f7::leverage_app::LeverageApp, arg2: 0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::app::PackageCallerCap) {
        0x6db226dfc4db6cd271c79ea7558968419511ee27b0adfaa73dad7c31bcd311f7::leverage_app::accept_protocol_caller_cap(arg1, arg2);
    }

    public fun onboard_market<T0>(arg0: &0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::app::AdminCap, arg1: &0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::market::Market<T0>, arg2: u8, arg3: &mut 0x2::tx_context::TxContext) {
        0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::market::assert_emode_group_exists<T0>(arg1, arg2);
        0x2::transfer::public_share_object<0x6db226dfc4db6cd271c79ea7558968419511ee27b0adfaa73dad7c31bcd311f7::leverage_market::LeverageMarket>(0x6db226dfc4db6cd271c79ea7558968419511ee27b0adfaa73dad7c31bcd311f7::leverage_market::new_market(0x2::object::id<0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::market::Market<T0>>(arg1), arg2, arg3));
    }

    public fun remove_protocol_caller_cap(arg0: &0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::app::AdminCap, arg1: &mut 0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::app::ProtocolApp, arg2: &mut 0x6db226dfc4db6cd271c79ea7558968419511ee27b0adfaa73dad7c31bcd311f7::leverage_app::LeverageApp) {
        0x6db226dfc4db6cd271c79ea7558968419511ee27b0adfaa73dad7c31bcd311f7::leverage_app::revoke_protocol_caller_cap(arg2, arg1);
    }

    // decompiled from Move bytecode v6
}

