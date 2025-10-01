module 0x601523f0fbdb81de1cb79b24d001a8aa85b9a848c337d51ab815fb476630b86c::worker_info_v1 {
    struct WorkerInfoV1 has copy, drop, store {
        worker_id: u8,
        worker_info: vector<u8>,
    }

    public fun create(arg0: u8, arg1: vector<u8>) : WorkerInfoV1 {
        WorkerInfoV1{
            worker_id   : arg0,
            worker_info : arg1,
        }
    }

    public fun decode(arg0: vector<u8>) : WorkerInfoV1 {
        let v0 = 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::buffer_reader::create(arg0);
        assert!(0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::buffer_reader::read_u16(&mut v0) == 1, 2);
        let v1 = 0x2::bcs::new(0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::buffer_reader::read_bytes_until_end(&mut v0));
        let v2 = 0x2::bcs::into_remainder_bytes(v1);
        assert!(0x1::vector::is_empty<u8>(&v2), 1);
        WorkerInfoV1{
            worker_id   : 0x2::bcs::peel_u8(&mut v1),
            worker_info : 0x2::bcs::peel_vec_u8(&mut v1),
        }
    }

    public fun encode(arg0: &WorkerInfoV1) : vector<u8> {
        let v0 = 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::buffer_writer::new();
        0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::buffer_writer::write_bytes(0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::buffer_writer::write_u16(&mut v0, 1), 0x2::bcs::to_bytes<WorkerInfoV1>(arg0));
        0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::buffer_writer::to_bytes(v0)
    }

    public fun worker_id(arg0: &WorkerInfoV1) : u8 {
        arg0.worker_id
    }

    public fun worker_info(arg0: &WorkerInfoV1) : &vector<u8> {
        &arg0.worker_info
    }

    // decompiled from Move bytecode v6
}

