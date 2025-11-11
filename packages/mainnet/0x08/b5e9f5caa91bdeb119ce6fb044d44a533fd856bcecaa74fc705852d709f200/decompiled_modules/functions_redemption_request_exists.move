module 0x8b5e9f5caa91bdeb119ce6fb044d44a533fd856bcecaa74fc705852d709f200::functions_redemption_request_exists {
    public fun redemption_request_exists(arg0: &0x8b5e9f5caa91bdeb119ce6fb044d44a533fd856bcecaa74fc705852d709f200::types_redemption_registry::RedemptionRegistry, arg1: 0x1::string::String) : bool {
        0x2::table::contains<0x1::string::String, bool>(0x8b5e9f5caa91bdeb119ce6fb044d44a533fd856bcecaa74fc705852d709f200::types_redemption_registry::get_processed_redemptions(arg0), arg1)
    }

    // decompiled from Move bytecode v6
}

