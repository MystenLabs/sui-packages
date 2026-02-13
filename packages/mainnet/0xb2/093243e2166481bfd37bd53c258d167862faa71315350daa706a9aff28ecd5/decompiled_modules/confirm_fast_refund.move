module 0xb2093243e2166481bfd37bd53c258d167862faa71315350daa706a9aff28ecd5::confirm_fast_refund {
    public fun confirm_fast_refund(arg0: &mut 0xb2093243e2166481bfd37bd53c258d167862faa71315350daa706a9aff28ecd5::state::State, arg1: vector<u8>, arg2: vector<u8>, arg3: u8) : 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::publish_message::MessageTicket {
        let v0 = 0xb2093243e2166481bfd37bd53c258d167862faa71315350daa706a9aff28ecd5::verify_ir::verify_and_extract_payload(arg1, arg2, arg3);
        let (v1, _, _, _, _, _, _) = 0xb2093243e2166481bfd37bd53c258d167862faa71315350daa706a9aff28ecd5::refund_message::unpack(0xb2093243e2166481bfd37bd53c258d167862faa71315350daa706a9aff28ecd5::refund_message::deserialize(v0));
        0xb2093243e2166481bfd37bd53c258d167862faa71315350daa706a9aff28ecd5::state::add_refunded_order(arg0, v1);
        0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::publish_message::prepare_message(0xb2093243e2166481bfd37bd53c258d167862faa71315350daa706a9aff28ecd5::state::borrow_mut_emitter_cap(arg0), 0, v0)
    }

    // decompiled from Move bytecode v6
}

