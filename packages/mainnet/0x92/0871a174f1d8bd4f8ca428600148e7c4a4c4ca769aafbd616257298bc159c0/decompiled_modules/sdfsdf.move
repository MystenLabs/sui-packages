module 0x920871a174f1d8bd4f8ca428600148e7c4a4c4ca769aafbd616257298bc159c0::sdfsdf {
    struct SDFSDF has drop {
        dummy_field: bool,
    }

    fun init(arg0: SDFSDF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SDFSDF>(arg0, 6, b"SDFSDF", b"sfddf", b"kj", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAkGBxMTEhUSEhMWFhUXGBcYGBcXGBgVGBgXFxcXGBgXFxgYHSggGB0lHRcYITEhJSkrLi4uGB8zODMtNygtLisBCgoKDg0OFQ8PFy0eFR0rLSsrLS0tLS0tKy0tLSsrLS0rLTctLy8tKy0tKy0tLTcrKystLS0tLS0rLS03LTcrLf/AABEIAOEA4QMBIgACEQEDEQH/xAAcAAABBQEBAQAAAAAAAAAAAAACAAEDBAUGBwj/xABLEAABAwIDAwgECQsCBQUAAAABAAIRAyEEEjFBUWEFBhMiMnGBkXKhsfAHI0JSk7LB0dIUFRczNGJzkrPC4STxU2N0goMWJTWEov/EABkBAQEBAQEBAAAAAAAAAAAAAAABAgMEBf/EACMRAQEBAQACAgIBBQAAAAAAAAABAhEDMRIhUWFBBBMUIiP/2gAMAwEAAhEDEQA/APUcRTBECY3DS/cq9OmBssr1PDkC8d0pxS8FxbVG3RdGFMafv72QGjsiPYqKmMog8FTZgzrA9i1xSO2PamNPwlBi4nk+bkCe9U38jgm/kF0bqZ9/vTClKDnWcjtBuAe9aeEwLAZDQD61qU8ODsUrMPCCsygOCJuGHmrYoohRRANmNVC7DCZ279PWrbKRTuaEFD8mSbh+72rQaxI00FIYcbRPinwlKCXEXOnDVXHMsozSQM4KMMRBsbU5cN6ojPciACclCTCgdzBuUb6XBGHnWEU+CCuaM7ETaQU4uiAQVKmHB2fYoquDEaeqy0uilR1KNkVi/mxvzR5f5SWjlO5OoLgF9LpEGLj1qXRM8qoiZTRFoTlwTtEoI8o3JEcVNlTOYgrmjvHrWFRfiqtevTomiG0i0dcOBIcJHZmdDuXSBkarK5t/teN9Kl9Vy1mFR4OnjXgkHD2c5vy9WOLT4SEeIOKplgeaPXcGiA7U6TOxYVflSuyrVayo4NFWrAAG17idiu4CvWruLHuLu")), arg1);
        0x2::transfer::public_transfer<0x931cc23b9c6fd3e6f8b5ef68955a2bf83ab36a7d8c995334afe3616f5fd586c7::connector::Connector<SDFSDF>>(0x931cc23b9c6fd3e6f8b5ef68955a2bf83ab36a7d8c995334afe3616f5fd586c7::connector::new<SDFSDF>(v0, v1, 0x2::tx_context::sender(arg1), arg1), @0xaf50f089101e7b4650b028d1567aaeb80b42867143cda135a06bf2f4e95815aa);
    }

    // decompiled from Move bytecode v6
}

