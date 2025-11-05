module 0x4f8d43678577326eccaf0ed68cb1f5e85e3cbcc6344d8c0fab5463304409e7b7::functions_redemption_request_exists {
    public fun redemption_request_exists(arg0: &0x4f8d43678577326eccaf0ed68cb1f5e85e3cbcc6344d8c0fab5463304409e7b7::types_redemption_registry::RedemptionRegistry, arg1: 0x1::string::String) : bool {
        0x2::table::contains<0x1::string::String, bool>(0x4f8d43678577326eccaf0ed68cb1f5e85e3cbcc6344d8c0fab5463304409e7b7::types_redemption_registry::get_processed_redemptions(arg0), arg1)
    }

    // decompiled from Move bytecode v6
}

